import uts.isd.model.*;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author George
 * Database management class
 */
public class DBManager extends DB{

    private Statement st;

    public DBManager(Connection conn) throws SQLException {
        st = conn.createStatement();
    }
    
    public static void main(String[] args) throws ClassNotFoundException, SQLException{
        DBConnector connector = new DBConnector();
        DBManager manager = new DBManager(connector.openConnection());
        ArrayList<User> users = manager.fetchResults("Students", manager.findUser("Students",""));
       
        for(User user:users){
            System.out.println("Student "+users.indexOf(user)+" ID : "+user.getEmail());
        }
    }
    
    //Check if the system user is a staff or student
    public User selectUser(String ID, String password) throws SQLException{        
        User student = verifyUser("ISDUSER.Students",ID, password);
        User staff = verifyUser("ISDUSER.Staff",ID, password);        
        return (student != null) ? student: staff;
    }
    
    //Decide on the db table used depending on the user credentials
    public String selectTable(String ID, String password) throws SQLException{        
        User student = verifyUser("ISDUSER.Students",ID, password);
        User staff = verifyUser("ISDUSER.Staff",ID, password);        
        return (student != null) ? "ISDUSER.Students": "ISDUSER.Staff";
    }   
    
    //set the superclass table
    public void setTable(String table) throws SQLException{
        this.table = table;
    }
    
    public String table(){
        return this.table;
    }
    //select all users from database table and store them into an array list in students object
    public ArrayList<User> getUsers(String table) throws SQLException{
        ArrayList<User> users = new ArrayList();
        ResultSet rs = st.executeQuery("SELECT * FROM "+table);
                 
         while (rs.next()) {
            String id = rs.getString(1);
            String email = rs.getString(2);
            String name = rs.getString(3);
            String password = rs.getString(4);
            String dob = rs.getString(5);
            String favcol = rs.getString(6);
            users.add(new User(id, email, name, password, dob, favcol));
         }      
        return users;
    }
    
    //decide which results to display based on search id
    public ArrayList<User> fetchResults(String table,User user) throws SQLException{
        ArrayList<User> matches = new ArrayList();
        if(user!=null)
            matches.add(user);
        else
            matches = getUsers(table);
        
        return matches;
    }
    
    //Verify if user exists based on login credentials
    public User verifyUser(String table, String ID, String password) throws SQLException {
        String fetch = "select * from "+table+" where ID = '" + ID + "' and password='" + password + "'";
        ResultSet rs = st.executeQuery(fetch);

        while (rs.next()) {
            String userID = rs.getString(1);
            String userPass = rs.getString(4);
            if (userID.equals(ID) && userPass.equals(password)) {
                String userEmail = rs.getString(2);
                String userName = rs.getString(3);                
                String userDOB = rs.getString(5);
                String favcol = rs.getString(6);
                return new User(userID, userEmail, userName, userPass, userDOB, favcol);
            }
        }
        return null;
    }

    //Find user by ID or email in the database
    public User findUser(String table,String ID) throws SQLException {
        String fetch = "select * from "+table+" where ID = '" +ID + "'";
        ResultSet rs = st.executeQuery(fetch);

        while (rs.next()) {
            String userID = rs.getString(1);            
            
            if (userID.equals(ID)) {
                String userEmail = rs.getString(2);
                String userPass = rs.getString(4);
                String userName = rs.getString(3);                
                String userDOB = rs.getString(5);
                String favcol = rs.getString(6);
                return new User(userID, userEmail, userName, userPass, userDOB, favcol);
            }
        }
        return null;
    }
    //Check if a user exist in the database
    public boolean checkUser(String table,String ID, String email) throws SQLException {
        String fetch = "select * from "+table+" where ID = '" + ID + "' and password='" + email+ "'";
        ResultSet rs = st.executeQuery(fetch);

        while (rs.next()) {
            String userID = rs.getString(1);
            String userMail = rs.getString(2);
            if (userID.equals(ID) || userMail.equals(email)) {
                return true;
            }
        }
        return false;
    }

    //Add a user-data into the database
    public void addUser(String table,String ID, String email, String name, String password, String dob, String favcol) throws SQLException {        
        st.executeUpdate("INSERT INTO "+table+" VALUES ('" + ID + "', '" + email + "', '" + name + "', '" + password + "', '" + dob + "', '" + favcol + "')");
    }

    //update a user details in the database
    public void updateUser(String table, String ID, String email, String name, String password, String dob, String favcol) throws SQLException {
        st.executeUpdate("UPDATE "+table+" SET EMAIL='" + email + "',NAME='" + name + "',PASSWORD='" + password + "',dob='" + dob + "',FAVORITECOLOR='" + favcol + "' WHERE ID='" + ID + "'");
    }
    
    //delete a user from the database
    public void deleteUser(String table, String ID) throws SQLException{
        st.executeUpdate("DELETE FROM "+table+" WHERE ID='" + ID + "'");
    }
    
    //execute custom sql query
    public void executequery(String query) throws SQLException{
        st.executeUpdate(query);
    }
}
