package com.telanoff.californiaholdem.client;

public class ClientSend {
    private ClientSend() {}

    public static void send(Packet packet) {
        packet.shiftLength();
        Client.send(packet);
        packet.dispose();
    }

    public static void sendWelcomeReceived() {
        Packet packet = new Packet(Packet.ClientPackets.WelcomeReceived.ordinal());
        packet.push(Client.id);
        packet.push("Test Username");

        send(packet);
    }
}
