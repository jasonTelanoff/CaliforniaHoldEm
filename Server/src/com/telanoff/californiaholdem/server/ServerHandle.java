package com.telanoff.californiaholdem.server;

import java.util.HashMap;

public class ServerHandle {
    public interface PacketHandle { void apply(Packet packet); }

    private ServerHandle() {}

    private static HashMap<Packet.ClientPackets, PacketHandle> packetHandlers;

    public static void handle(Packet packet) {
        packetHandlers.get(packet.readInt()).apply(packet);
    }

    public static void initializeHandlers() {
        packetHandlers = new HashMap<Packet.ClientPackets, PacketHandle>() {{
            put(Packet.ClientPackets.WelcomeReceived, ServerHandle::handleWelcomeReceived);
        }};
    }

    public static void handleWelcomeReceived(Packet packet) {

    }
}
