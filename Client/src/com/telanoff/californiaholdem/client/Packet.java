package com.telanoff.californiaholdem.client;

import java.nio.*;
import java.util.*;

public class Packet {
    public enum ServerPackets {
        Welcome
    }

    public enum ClientPackets {
        WelcomeReceived
    }

    private Vector<Byte> buffer = new Vector<>();
    private int readLength;

    public Packet() {}

    public Packet(int id) {
        push(id);
    }

    public Packet(byte[] buffer) {
        for (byte value : buffer)
            this.buffer.add(value);
    }

    public void dispose() {
        buffer.clear();
        readLength = 0;
    }

    public void shiftLength() {
        shift(ByteBuffer.allocate(Integer.BYTES).putInt(buffer.size()).array());
    }

    public void shift(byte[] values) {
        for (int i = 0; i < values.length; i++)
            buffer.add(i, values[i]);
    }

    public void push(byte[] values) {
        for (byte value : values)
            buffer.add(value);
    }

    public void push(byte value) {
        buffer.add(value);
    }

    public void push(short value) {
        push(ByteBuffer.allocate(Short.BYTES).putShort(value).array());
    }

    public void push(int value) {
        push(ByteBuffer.allocate(Integer.BYTES).putInt(value).array());
    }

    public void push(long value) {
        push(ByteBuffer.allocate(Long.BYTES).putLong(value).array());
    }

    public void push(char value) {
        push(ByteBuffer.allocate(Character.BYTES).putChar(value).array());
    }

    public void push(String value) {
        push(value.length());
        for (char c : value.toCharArray())
            push(c);
    }

    public byte[] readBytes(int count) {
        if (readLength + count < buffer.size())
            return getBytes(readLength, readLength += count);
        else
            return new byte[count];
    }

    public byte readByte() {
        byte[] bytes = readBytes(Byte.BYTES);

        return bytes[0];
    }

    public short readShort() {
        return ByteBuffer.wrap(readBytes(Short.BYTES)).getShort();
    }

    public int readInt() {
        return ByteBuffer.wrap(readBytes(Integer.BYTES)).getInt();
    }

    public long readLong() {
        return ByteBuffer.wrap(readBytes(Long.BYTES)).getLong();
    }

    public char readChar() {
        return ByteBuffer.wrap(readBytes(Character.BYTES)).getChar();
    }

    public String readString() {
        int length = readInt();
        StringBuilder out = new StringBuilder();
        for (int i = 0; i < length; i++) {
            out.append(readChar());
        }

        return out.toString();
    }

    public byte[] getBytes(int start, int end) {
        return Arrays.copyOfRange(getBuffer(), start, end);
    }

    public byte[] getBuffer() {
        byte[] bytes = new byte[buffer.size()];
        for (int i = 0; i < buffer.size(); i++)
            bytes[i] = buffer.get(i);

        return bytes;
    }

    public int getLength() {
        return buffer.size();
    }

    public int getReadLength() {
        return readLength;
    }

    public int getUnreadLength() {
        return getLength() - getReadLength();
    }
}
