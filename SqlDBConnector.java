package com.edu.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class SqlDBConnector extends SqlDB {

    public SqlDBConnector() throws ClassNotFoundException, SQLException {
        Class.forName(driver);
        super.conn = DriverManager.getConnection(URL, dbuser, dbpass);
    }

    public Connection connection() {
        return this.conn;
    }

    public void closeConnection() throws SQLException {
        this.conn.close();
    }
}

