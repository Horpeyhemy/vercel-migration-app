import { sql } from '@vercel/postgres';
import { NextResponse } from 'next/server';

export async function GET() {
  try {
    await sql`
      INSERT INTO messages (content)
      VALUES ('Hello from Vercel Postgres!'),
             ('This app is ready for migration to Azure!');
    `;
    return NextResponse.json({ message: "Sample data inserted" });
  } catch (error: any) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
