"use client";

import { useEffect, useState } from "react";

export default function Home() {
  const [messages, setMessages] = useState<any[]>([]);
  const [content, setContent] = useState("");

  async function loadMessages() {
    const res = await fetch("/api/messages");
    const data = await res.json();
    setMessages(data);
  }

  async function addMessage() {
    if (!content) return;
    await fetch("/api/messages", {
      method: "POST",
      body: JSON.stringify({ content }),
    });
    setContent("");
    loadMessages();
  }

  useEffect(() => {
    loadMessages();
  }, []);

  return (
    <div style={{ padding: 20 }}>
      <h1>Vercel Migration App</h1>

      <input
        placeholder="Enter message"
        value={content}
        onChange={(e) => setContent(e.target.value)}
        style={{ marginRight: 8 }}
      />
      <button onClick={addMessage}>Add Message</button>

      <ul>
        {messages.map((msg) => (
          <li key={msg.id}>{msg.content}</li>
        ))}
      </ul>
    </div>
  );
}
