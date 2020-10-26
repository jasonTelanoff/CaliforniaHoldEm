package com.telanoff.californiaholdem.server;

import java.io.*;
import java.net.*;
import java.util.*;

public class Server {


    private Server() {}

    public static HashMap<Integer, ServerClient> serverClients = new HashMap<>();

    private static ServerSocket socket;

    private static int port;
    private static int maxPlayers;

    public static void Start(int port, int maxPlayers) {
        Server.port = port;
        Server.maxPlayers = maxPlayers;

        try {
            socket = new ServerSocket(port);
        } catch (IOException e) {
            System.err.println("Cannot start server: " + e);
        }
    }

    private static void initializeServerClients()
    {
        for (int i = 1; i <= maxPlayers; i++)
            serverClients.put(i, new ServerClient(i));
        System.out.println("Initialized Server Clients.");
    }

    public static int getPort() {
        return port;
    }

    public static int getMaxPlayers() {
        return maxPlayers;
    }
}
