package com.telanoff.californiaholdem.client;

public class Main {
    public static Thread mainThread;
    public static volatile boolean isRunning;

    public static final long FPS = 20;
    public static final long MILIS = 1000 / FPS;

    public static final int PORT = 56565;

    public static void main(String[] args) {
        isRunning = true;

        ClientHandle.initializeHandlers();
        Client.connect("127.0.0.1", PORT);

        mainThread = new Thread(() -> {
            long nextLoop = System.currentTimeMillis();

            while (isRunning) {
                while (nextLoop < System.currentTimeMillis()) {
                    Client.update();

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
    }
}
