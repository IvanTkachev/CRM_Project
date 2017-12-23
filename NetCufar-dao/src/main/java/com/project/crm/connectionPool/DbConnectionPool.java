package com.project.crm.connectionPool;


import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Deque;
import java.util.LinkedList;
import java.util.ResourceBundle;


public class DbConnectionPool {


    private String url;
    private String user;
    private String password;
    private String driverName;


    private static DbConnectionPool instance;

    private Deque<Connection> connections;

    private DbConnectionPool(){

        try {
            ResourceBundle resourceBundle = ResourceBundle.getBundle("database");
            driverName = resourceBundle.getString("jdbc.driverClassName");
            url = resourceBundle.getString("jdbc.url");
            user = resourceBundle.getString("jdbc.username");
            password = resourceBundle.getString("jdbc.password");
            Driver driver =  (Driver)Class.forName(driverName).newInstance();
            DriverManager.registerDriver(driver);
            this.connections = new LinkedList<>();

        }
        catch(InstantiationException | IllegalAccessException | ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }
    }

    public synchronized Connection getConnection() {
        if(!connections.isEmpty()) {
            return connections.poll();
        }

        Connection connection = null;
        try {
            connection = DriverManager.getConnection(url, user, password);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public void footConnection(Connection connection) {
        try {
            if (!connection.isClosed()) {
                connections.add(connection);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static DbConnectionPool getInstance() {
        if (instance == null) {
            synchronized (DbConnectionPool.class) {
                instance = new DbConnectionPool();
                return instance;
            }
        }
        return instance;
    }
}


