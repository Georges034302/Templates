package com.edu.model.dao;
//MySQL connection configuration template
import java.sql.Connection;

public abstract class SqlDB {
        protected String URL = "jdbc:mysql://localhost:1433/<db-name-here>?zeroDateTimeBehavior=CONVERT_TO_NULL";
        protected String db = "db-name-here";
        protected String dbuser = "db-user-here";
        protected String dbpass = "db-password-here";
        protected String driver = "com.mysql.cj.jdbc.Driver";
        protected Connection conn;
}
