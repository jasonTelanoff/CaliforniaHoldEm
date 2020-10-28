package com.telanoff.californiaholdem.client;

import java.io.*;
import java.net.*;

public class Client {
    private Client() {}

    static int id;

    public static String ip;
    public static int port;

    private static Socket socket;
    private static DataInputStream in;
    private static DataOutputStream out;

    private static Packet currentPacket = new Packet();

    public static void connect(String ip, int port) {
        try {
            Client.ip = ip;
            Client.port = port;

            socket = new Socket(ip, port);
            in = new DataInputStream(socket.getInputStream());
            out = new DataOutputStream(socket.getOutputStream());

            System.out.println("Connected to " + ip + ":" + port);
        } catch (IOException e) {
            System.err.println("Error connecting to '" + ip + ":" + port + "': " + e.getCause());
        }
    }

    public static void disconnect() {
        try {
            socket.close();
            socket = null;
            in = null;
            out = null;

            System.out.println("Disconnecting...");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void update() {
        if (socket == null)
            System.exit(0);

        try {
            if (in.available() > 0) {
                currentPacket.dispose();

                int packetLength = in.readInt();

                if (packetLength < 1)
                    disconnect();

                byte[] buffer = new byte[packetLength];
                in.read(buffer);

                currentPacket.push(buffer);
                handle(buffer);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void send(Packet packet) {
        if (socket == null)
            System.exit(0);

        try {
            out.write(packet.getBuffer());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void handle(byte[] buffer) {
        ThreadManager.executeOnMainThread(() -> {
            ClientHandle.handle(new Packet(buffer));
        });
    }

    public static int getId() {
        return id;
    }
}
