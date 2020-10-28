package com.telanoff.californiaholdem.server;

import java.util.HashMap;

public class ServerHandle {
    public interface PacketHandle { void apply(int clientId, Packet packet); }

    private ServerHandle() {}

    private static HashMap<Integer, PacketHandle> packetHandlers;

    public static void handle(int clientId, Packet packet) {
        packetHandlers.get(packet.readInt()).apply(clientId, packet);
        packet.dispose();
    }

    public static void initializeHandlers() {
        packetHandlers = new HashMap<Integer, PacketHandle>() {{
            put(Packet.ClientPackets.WelcomeReceived.ordinal(), ServerHandle::handleWelcomeReceived);
        }};
    }

    public static void handleWelcomeReceived(int clientId, Packet packet) {
        int packetClientId = packet.readInt();
        String username = packet.readString();

        if (packetClientId == clientId) {
            System.out.println("Welcome received from " + username);
        } else {
            System.out.println(username + " has assumed wrong client Id, disconnecting...");
            Server.serverClients.get(clientId).disconnect();
        }
    }
}
