package com.telanoff.californiaholdem.server;

import java.net.*;
import java.io.*;
import java.util.Random;

public class Main {
    public static void main(String[] args) {
        while (true) {
            try {
                ServerSocket socket = new ServerSocket(12345);
                Socket client = socket.accept();
                Random random = new Random();

                System.out.println("Just connected to " + client.getRemoteSocketAddress());
                DataInputStream in = new DataInputStream(client.getInputStream());

                DataOutputStream out = new DataOutputStream(client.getOutputStream());

                while (client.isConnected()) {
                    out.write(String.format("%d %d %d %d\n", random.nextInt(450), random.nextInt(255), random.nextInt(450), random.nextInt(255)).getBytes());

                    while (in.available() > 0) {
                        System.out.print((char)in.readByte());
                    }
                }

                socket.close();
                client.close();
            } catch (SocketTimeoutException e) {
                System.out.println("Timed out!");
            } catch (IOException e) {
                e.printStackTrace();
                break;
            }
        }
    }
}