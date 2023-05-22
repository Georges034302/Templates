    #!/bin/bash
    DATE=`date '+%Y-%m-%d %H:%M:%S'`
    echo
    echo "Running create-instance.sh on "$DATE
    echo
    vpcTag="cafe-vpc"
    publicsubnetTag="cafe-public-subnet-a"
    privatesubnetTag="cafe-private-subnet-b"
    cafeserverTag="cafeserver"
    cafesgTag="cafesg"
    igwTag="cafeIGW"
    rtTag="cafeRT"
    type="t2.micro"
    keypair="cafekeypair"
    region="ap-southeast-2"

    # Hard coded values
    echo "Instance Type: "$type
    profile="default"
    echo "Profile: "$profile
    echo

    echo "Looking up VPC availability in regions ..."
    vpc=""
    for i in $(aws ec2 describe-regions | grep RegionName | cut -d '"' -f4) ; do
      echo $i
      vpc=$(aws ec2 describe-vpcs --region $i --filters "Name=tag:Name,Values=$vpcTag" | grep VpcId | cut -d '"' -f4 | sed -n 1p);
      if [[ "$vpc" != "" ]]; then
        region=$i
        break;
      fi
    done
    echo
    if [[ "$vpc" == "" ]];then
      echo "Cafe VPC is not configured in any region. Setting VPC region: $region"
      echo
    fi


    if [[ "$vpc" != "" ]]; then  
      echo "Cafe VPC is configured in region: $region"      
      vpc=$(aws ec2 describe-vpcs \
        --filters "Name=tag:Name,Values='$vpcTag'" \
        --region $region \
        --profile $profile | grep VpcId | cut -d '"' -f4 | sed -n 1p)
      echo "Found VPC: "$vpc

      subnetId=$(aws ec2 describe-subnets \
        --filters "Name=tag:Name,Values='$publicsubnetTag'" \
        --region $region \
        --profile $profile \
        --query "Subnets[*]" | grep SubnetId | cut -d '"' -f4 | sed -n 1p)
      echo "Found Public Subnet Id: "$subnetId
      echo
      
    else 
      echo "Creating VPC environment in region $region ..."
      vpc=$(aws ec2 create-vpc \
        --cidr-block 10.0.0.0/16 \
        --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value='$vpcTag'}]' \
        --profile $profile | grep VpcId | cut -d '"' -f4 | sed -n 1p)
      echo "VPC: "$vpc

      publicsubnetId=$(aws ec2 create-subnet --vpc-id $vpc --cidr-block 10.0.1.0/24 \
        --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value='$publicsubnetTag'}]' \
        --profile $profile | grep SubnetId | cut -d '"' -f4 | sed -n 1p) 
      echo "Public Subnet: "$publicsubnetId

      privatesubnetId=$(aws ec2 create-subnet --vpc-id $vpc --cidr-block 10.0.0.0/24 \
        --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value='$privatesubnetTag'}]' \
        --profile $profile | grep SubnetId | cut -d '"' -f4 | sed -n 1p)
      echo "Private Subnet: "$privatesubnetId

      igwId=$(aws ec2 create-internet-gateway \
        --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value='$igwTag'}]' \
        --profile $profile | grep InternetGatewayId | cut -d '"' -f4 | sed -n 1p)
      echo "IGW: "$igwId
      
      aws ec2 attach-internet-gateway \
      --vpc-id $vpc \
      --internet-gateway-id $igwId
      echo "$igwId is attached to $vpc"
      
      rtId=$(aws ec2 create-route-table --vpc-id $vpc \
        --profile $profile | grep RouteTableId | cut -d '"' -f4 | sed -n 1p)
      echo "Route Table: "$rtId
      
      aws ec2 create-route \
      --route-table-id $rtId \
      --destination-cidr-block 0.0.0.0/0 \
      --gateway-id $igwId  

      associateId=$(aws ec2 associate-route-table \
        --subnet-id $publicsubnetId \
        --route-table-id $rtId \
        --profile $profile | grep AssociationId | cut -d '"' -f4 | sed -n 1p)
      echo "$rtId is associated with $publicsubnetId. Association ID: $associateId"
      
      aws ec2 modify-subnet-attribute \
      --subnet-id $publicsubnetId \
      --map-public-ip-on-launch

    fi

    #check for existing cafeSG security Group
    sgId=$(aws ec2 describe-security-groups \
      --region $region \
      --query "SecurityGroups[?contains(GroupName, '$cafesgTag')]" \
      --profile $profile | grep GroupId | cut -d '"' -f4)

    if [[ "$sgId" != "" ]]; then
      echo
      echo "WARNING: Found existing security group with name "$sgId"."
      echo "This script will not succeed if it already exists. "
      echo "Would you like to delete it? [Y/N]"
      echo ">>"

      validResp=0
      while [ $validResp -eq 0 ];
      do
        read answer
        if [[ "$answer" == "Y" || "$answer" == "y" ]]; then
          echo
          echo "Deleting the existing security group..."
          aws ec2 delete-security-group --group-id $sgId --region $region --profile $profile
          validResp="1"
        elif [[ "$answer" == "N" || "$answer" == "n" ]]; then
          echo "Ok, exiting."
          exit 1
        else
          echo "Please reply with Y or N."
        fi
      done
      sleep 10 #give it 10 seconds before trying to recreate the SG
    fi

    # CREATE a security group and capture the name of it
    echo
    echo "Creating a new security group..."
    sgId=$(aws ec2 create-security-group --group-name "$cafesgTag" \
      --description "$cafesgTag" \
      --region $region \
      --group-name "$cafesgTag" \
      --vpc-id $vpc --profile $profile | grep GroupId | cut -d '"' -f4 )
    echo "Security Group: "$sgId

    # Open ports in the security group
    
    echo "Opening port 22 in the new security group"
    aws ec2 authorize-security-group-ingress \
    --group-id $sgId \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0 \
    --region $region \
    --profile $profile

    echo "Opening port 80 in the new security group"
    aws ec2 authorize-security-group-ingress \
    --group-id $sgId \
    --protocol tcp \
    --port 8080 \
    --cidr 0.0.0.0/0 \
    --region $region \
    --profile $profile
    
    echo "Opening port 80 in the new security group"
    aws ec2 authorize-security-group-ingress \
    --group-id $sgId \
    --protocol tcp \
    --port 443 \
    --cidr 0.0.0.0/0 \
    --region $region \
    --profile $profile

    echo "Checking for key-pair: $keypair"
    existingkey=$(aws ec2 describe-key-pairs \
      --profile $profile --region $region | grep KeyName | cut -d '"' -f4 )
    echo "- Found Key: "$existingkey
    if [[ "$existingkey" == "$keypair" ]]; then
      key=$existingkey
    else
      echo "$keypair does not exist. Creating new keypair..."
      key=$(aws ec2 create-key-pair \
        --key-name $keypair \
        --profile $profile | grep KeyName | cut -d '"' -f4 | sed -n 1p)
      echo "- Using Key: "$key
    fi

    amiId=$(aws ec2 describe-images \
      --owners amazon \
      --filters "Name=name,Values=amzn2-ami-hvm-2.0.????????.?-x86_64-gp2" "Name=state,Values=available" \
      --query "reverse(sort_by(Images, &Name))[:1].ImageId" \
      --region $region \
      --output text)
    echo "AMI: "$amiId
    echo

    #check for existing cafe instance
    existingEc2Instance=$(aws ec2 describe-instances \
      --region $region \
      --profile $profile \
      --filters "Name=tag:Name,Values='$cafeserverTag'" "Name=instance-state-name,Values=running" \
      | grep InstanceId | cut -d '"' -f4)
    if [[ "$existingEc2Instance" != "" ]]; then
      echo
      echo "WARNING: Found existing running EC2 instance with instance ID "$existingEc2Instance"."
      echo "This script will not succeed if it already exists. "
      echo "Would you like to delete it? [Y/N]"
      echo ">>"

      validResp=0
      while [ $validResp -eq 0 ];
      do
        read answer
        if [[ "$answer" == "Y" || "$answer" == "y" ]]; then
          echo
          echo "Deleting the existing instance..."
          aws ec2 terminate-instances --instance-ids $existingEc2Instance --region $region --profile $profile
              #wait for confirmation it was terminated
              aws ec2 wait instance-terminated --instance-ids $existingEc2Instance --region $region --profile $profile
              validResp="1"
            elif [[ "$answer" == "N" || "$answer" == "n" ]]; then
              echo "Ok, exiting."
              exit 1
            else
              echo "Please reply with Y or N."
            fi
          done

      sleep 10 #give it 10 seconds before trying to delete the SG this instance used.
    fi

    echo "Creating an EC2 instance in $vpc in $region"
    instanceDetails=$(aws ec2 run-instances \
      --image-id $amiId \
      --count 1 \
      --instance-type $type \
      --region $region \
      --subnet-id $privatesubnetId \
      --security-group-ids $sgId \
      --key-name $key \
      --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value='$cafeserverTag'}]' \
      --associate-public-ip-address \
      --profile $profile \
      --user-data file://C:\\Users\\George\\Google\ Drive\\Goanna\\demo\\userData.txt)

  #if the create instance command failed, exit this script
  if [[ "$?" -ne "0" ]]; then
    exit 1
  fi

  echo
  echo "Instance Details...."
  echo $instanceDetails | python -m json.tool

  # Extract instanceId
  instanceId=$(echo $instanceDetails | python -m json.tool | grep InstanceId | sed -n 1p | cut -d '"' -f4)
  echo "instanceId="$instanceId
  echo
  echo "Waiting for a public IP for the new instance..."
  pubIp=""
  while [[ "$pubIp" == "" ]]; do
    sleep 10;
    pubIp=$(aws ec2 describe-instances --instance-id $instanceId --region $region --profile $profile | grep PublicIp | sed -n 1p | cut -d '"' -f4)
  done

  echo
  echo "The $cafeserverTag is now running ..."
  echo
  echo "SSH to $cafeserverTag (with .pem or .ppk added to the end of the keypair name):"
  echo "ssh -i "$key.pem" ec2-user@"$pubIp
  echo
  echo "The website should also become available at"
  echo "http://"$pubIp"/"
  echo
  echo "Upload MomPopCafe wbsite using the following scp command: "
  echo "step 1: cd MomPopCafe"
  echo "step 2: scp -i $key.pem -r . ec2-user@\$pub:~"
  echo "step 4: ssh to the $cafeserverTag using $key"
  echo "step 3: sudo cp -R . /var/www/html/"
  echo
  DATE=`date '+%Y-%m-%d %H:%M:%S'`
  echo
  echo "Done running create-instance.sh at "$DATE
  echo