package com.telanoff.californiaholdem.server;

import java.net.*;
import java.io.*;

public class ServerClient {
    public final int id;
    public Socket socket;

    public ServerClient(int id, Socket socket) {
        this.id = id;
        this.socket = socket;
    }
}
