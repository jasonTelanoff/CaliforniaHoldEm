package com.telanoff.californiaholdem.server;

import java.net.*;
import java.io.*;

public class ServerClient {
    public final int id;
    private Socket socket;
    private DataInputStream in;
    private DataOutputStream out;

    private Packet currentPacket = new Packet();

    public ServerClient(int id) {
        this.id = id;
    }

    public void connect(Socket socket) {
        this.socket = socket;
        try {
            in = new DataInputStream(socket.getInputStream());
            out = new DataOutputStream(socket.getOutputStream());
        } catch(IOException e) {
            System.err.println("Error Establishing Connection: " + e);
        }
    }

    public void disconnect() {

    }

    public void update() {
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

    public void send(Packet packet) {
        try {
            if (socket != null && socket.isConnected()) {
                out.write(packet.getBuffer());
            }
        } catch (Exception e) {

        }
    }

    public void handle(byte[] buffer) {
        ThreadManager.executeOnMainThread(() -> {
            Packet packet = new Packet(buffer);
            int packetID = packet.readInt();

            packet.dispose();
        });
    }
}
