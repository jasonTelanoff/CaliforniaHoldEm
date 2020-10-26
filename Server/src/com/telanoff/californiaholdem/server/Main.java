package com.telanoff.californiaholdem.server;

import java.net.*;
import java.io.*;
import java.time.*;
import java.util.*;

public class Main {
    public static Thread mainThread;
    public static volatile boolean isRunning;

    public static final long FPS = 20;
    public static final long MILIS = 1000 / FPS;

    public static final int PORT = 56565;

    public static void main(String[] args) {
        isRunning = true;

        mainThread = new Thread(() -> {
            long nextLoop = System.currentTimeMillis();

            while (isRunning) {
                while (nextLoop < System.currentTimeMillis()) {
                    for (ServerClient client : Server.serverClients.values())
                        client.update();

                    ThreadManager.update();

                    nextLoop += MILIS;

                    if (nextLoop > System.currentTimeMillis()) {
                        try {
                            Thread.sleep(nextLoop - System.currentTimeMillis());
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        });
        mainThread.start();

        Server.Start(PORT, 6);
    }
}