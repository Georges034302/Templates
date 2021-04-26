import java.sql.Connection;

/**
 *
 * @author George
 */
public abstract class DB {
    protected String URL = "jdbc:derby://localhost:1527/";
    protected String db = "studentsdb";
    protected String dbuser = "isduser";
    protected String dbpass = "admin"; 
    protected String driver = "org.apache.derby.jdbc.ClientDriver";
    protected Connection conn;   
    protected String table;
}
