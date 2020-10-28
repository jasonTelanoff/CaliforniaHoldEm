package com.telanoff.californiaholdem.client;

import java.util.Vector;

public class ThreadManager {
    public interface Action { void apply(); }

    private static Vector<Action> actions = new Vector<>();

    private ThreadManager() {}

    public static void executeOnMainThread(Action action) {
        actions.add(action);
    }

    public static void update() {
        for (int i = actions.size() - 1; i >= 0; i--) {
            actions.get(i).apply();
            actions.remove(i);
        }
    }
}
