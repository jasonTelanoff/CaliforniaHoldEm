package com.telanoff.californiaholdem.server;

public class ServerSend {
    public static void send(int clientId, Packet packet) {
        packet.shiftLength();
        Server.serverClients.get(clientId).send(packet);
    }

    public static void sendToAll(int except, Packet packet) {
        packet.shiftLength();
        for (int i = 1; i < Server.getMaxPlayers(); i++)
            if (i != except)
                Server.serverClients.get(i).send(packet);
    }

    public static void sendToAll(Packet packet) {
        for (int i = 1; i < Server.getMaxPlayers(); i++)
            Server.serverClients.get(i).send(packet);
    }

    public static void sendWelcome(int clientId, String msg) {
        Packet packet = new Packet();
        packet.push(clientId);
        packet.push(msg);

        send(clientId, packet);
    }
}
