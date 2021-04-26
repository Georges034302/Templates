import uts.isd.model.dao.DBManager;
import uts.isd.model.dao.DBConnector;
import java.sql.*;
import java.util.*;
import java.util.logging.*;

public class TestDB {
    private static Scanner in = new Scanner(System.in);
    
    public static void main(String[] args) {
        try {
            DBConnector connector = new DBConnector();
            Connection conn = connector.openConnection();
            DBManager db = new DBManager(conn);
            
            int key = (new Random()).nextInt(999999);
            String ID = "" + key; 
            System.out.print("Student email: ");
            String email = in.nextLine();
            System.out.print("Student name: ");
            String name = in.nextLine();
            System.out.print("Student password: ");
            String password = in.nextLine();
            System.out.print("Student DOB: ");
            String dob = in.nextLine();
            System.out.print("Student favorite color: ");
            String favcol = in.nextLine();
            db.addUser("ISDUSER.Students",ID, email, name, password, dob, favcol);
            System.out.println("Student is added to the database.");
            connector.closeConnection();
            
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(TestDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
