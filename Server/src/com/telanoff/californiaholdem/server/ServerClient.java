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

            System.out.println("Incoming connection from '" + socket.getLocalAddress() + ":" + socket.getLocalPort() + "'");
            ServerSend.sendWelcome(id, "Welcome to the server!");
        } catch(IOException e) {
            System.err.println("Error Establishing Connection: " + e);
        }
    }

    public void disconnect() {
        try {
            socket.close();
            socket = null;
            in = null;
            out = null;
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public boolean isConnected() {
        return socket != null && socket.isConnected();
    }

    public void update() {
        if (in == null)
            return;

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
        if (out == null)
            return;

        try {
            if (socket != null && socket.isConnected()) {
                out.write(packet.getBuffer());
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void handle(byte[] buffer) {
        ThreadManager.executeOnMainThread(() -> {
            ServerHandle.handle(id, new Packet(buffer));
        });
    }
}
