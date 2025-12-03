export async function fetchUsers() {
  const res = await fetch(`${process.env.NEXT_PUBLIC_PROXY_URL}/api/db`);
  return res.json();
}

export async function addUser(name: string) {
  const res = await fetch(`${process.env.NEXT_PUBLIC_PROXY_URL}/api/db`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ name }),
  });

  return res.json();
}
