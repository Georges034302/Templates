import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author George
 */
public class DBConnector extends DB{

    public DBConnector() throws ClassNotFoundException, SQLException {
        Class.forName(driver);
        conn = DriverManager.getConnection(URL+db, dbuser, dbpass);
    }

    DBConnector(Connection openConnection) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public Connection openConnection(){
        return this.conn;
    }
    
    public void closeConnection() throws SQLException {
        this.conn.close();
    }
}
