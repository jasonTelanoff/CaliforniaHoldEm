package com.telanoff.californiaholdem.client;

import java.util.Arrays;
import java.util.HashMap;

public class ClientHandle {
    public interface PacketHandle { void apply(Packet packet); }

    private ClientHandle() {}

    private static HashMap<Integer, PacketHandle> packetHandlers;

    public static void handle(Packet packet) {
        System.out.println("Packet Received" + Arrays.toString(packet.getBuffer()));

        packetHandlers.get(packet.readInt()).apply(packet);
        packet.dispose();
    }

    public static void initializeHandlers() {
        packetHandlers = new HashMap<Integer, PacketHandle>() {{
            put(Packet.ServerPackets.Welcome.ordinal(), ClientHandle::handleWelcome);
        }};
    }

    public static void handleWelcome(Packet packet) {
        Client.id = packet.readInt();
        String msg = packet.readString();

        System.out.println("Message from server: " + msg);

        ClientSend.sendWelcomeReceived();
    }
}
