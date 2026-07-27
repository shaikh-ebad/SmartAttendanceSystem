<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smart Attendance Login</title>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;1,300&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">

<style>
  *, *::before, *::after {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
  }

  :root {
    --gold: #c8a97e;
    --gold-dim: #c8a97e55;
    --bg-dark: #0d0c0b;
    --bg-card: #161513;
    --bg-field: #0d0c0b;
    --text-primary: #f0e8dc;
    --text-muted: #6b6259;
    --text-light: #a09080;
    --border: #ffffff14;
    --border-hover: #ffffff22;
  }

  body {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #0d0c0b;
    font-family: 'DM Sans', sans-serif;
    padding: 1.5rem;
    position: relative;
    overflow: hidden;
  }

  /* Background orbs */
  body::before {
    content: '';
    position: fixed;
    width: 400px; height: 400px;
    border-radius: 50%;
    background: #c8a97e0f;
    filter: blur(100px);
    top: -100px; left: -100px;
    pointer-events: none;
  }
  body::after {
    content: '';
    position: fixed;
    width: 300px; height: 300px;
    border-radius: 50%;
    background: #c8a97e08;
    filter: blur(80px);
    bottom: -60px; right: -60px;
    pointer-events: none;
  }

  /* Square card — equal width and height */
  .card {
    position: relative;
    z-index: 1;
    width: min(700px, 95vw);
    aspect-ratio: 1 / 1;
    background: var(--bg-card);
    border: 0.5px solid var(--border);
    border-radius: 24px;
    display: grid;
    grid-template-columns: 1fr 1fr;
    overflow: hidden;
    animation: fadeUp 0.65s cubic-bezier(0.22, 1, 0.36, 1) both;
  }

  @keyframes fadeUp {
    from { opacity: 0; transform: translateY(24px) scale(0.98); }
    to   { opacity: 1; transform: translateY(0) scale(1); }
  }

  /* ── LEFT PANEL ── */
  .panel-left {
    background: #111009;
    border-right: 0.5px solid var(--border);
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    padding: 2.2rem 2rem;
    position: relative;
    overflow: hidden;
  }

  .panel-left::before {
    content: '';
    position: absolute;
    inset: 0;
    background: radial-gradient(ellipse at 20% 80%, #c8a97e0d 0%, transparent 70%);
    pointer-events: none;
  }

  /* Decorative geometric SVG behind */
  .geo {
    position: absolute;
    bottom: -40px;
    right: -40px;
    opacity: 0.06;
  }

  .brand {
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .brand-mark {
    width: 34px; height: 34px;
    border: 0.5px solid var(--gold-dim);
    border-radius: 9px;
    display: flex; align-items: center; justify-content: center;
    flex-shrink: 0;
  }

  .brand-name {
    font-family: 'Cormorant Garamond', serif;
    font-size: 16px;
    font-weight: 300;
    color: #e8ddd0;
    letter-spacing: 0.14em;
    text-transform: uppercase;
  }

  .welcome-block { flex: 1; display: flex; flex-direction: column; justify-content: center; }

  .welcome-label {
    font-size: 10px;
    font-weight: 400;
    letter-spacing: 0.18em;
    text-transform: uppercase;
    color: var(--gold);
    margin-bottom: 0.6rem;
  }

  .welcome-heading {
    font-family: 'Cormorant Garamond', serif;
    font-size: 32px;
    font-weight: 300;
    color: var(--text-primary);
    line-height: 1.2;
    margin-bottom: 1rem;
  }

  .welcome-heading em {
    font-style: italic;
    color: var(--gold);
  }

  .welcome-desc {
    font-size: 13px;
    font-weight: 300;
    color: var(--text-muted);
    line-height: 1.7;
    max-width: 200px;
  }

  .left-footer {
    font-size: 11px;
    font-weight: 300;
    color: #3d3830;
    letter-spacing: 0.04em;
  }

  /* Dots pattern */
  .dots {
    position: absolute;
    top: 2rem;
    right: 1.5rem;
    display: grid;
    grid-template-columns: repeat(4, 6px);
    gap: 5px;
    opacity: 0.15;
  }
  .dots span {
    width: 3px; height: 3px;
    border-radius: 50%;
    background: var(--gold);
  }

  /* ── RIGHT PANEL ── */
  .panel-right {
    padding: 2.2rem 2rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 0;
  }

  .form-title {
    font-family: 'Cormorant Garamond', serif;
    font-size: 22px;
    font-weight: 300;
    color: var(--text-primary);
    margin-bottom: 0.2rem;
  }

  .form-sub {
    font-size: 12px;
    font-weight: 300;
    color: var(--text-muted);
    margin-bottom: 1.6rem;
    letter-spacing: 0.01em;
  }

  .divider {
    width: 28px; height: 0.5px;
    background: var(--gold-dim);
    margin-bottom: 1.6rem;
  }

  .field { margin-bottom: 0.9rem; }

  .field label {
    display: block;
    font-size: 10px;
    font-weight: 400;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    color: var(--text-muted);
    margin-bottom: 5px;
  }

  .field input,
  .field select {
    width: 100%;
    background: var(--bg-field);
    border: 0.5px solid var(--border);
    border-radius: 10px;
    padding: 10px 13px;
    font-family: 'DM Sans', sans-serif;
    font-size: 13px;
    font-weight: 300;
    color: var(--text-primary);
    outline: none;
    transition: border-color 0.2s;
    -webkit-appearance: none;
  }

  .field input::placeholder { color: #3d3830; }
  .field input:focus,
  .field select:focus { border-color: var(--gold-dim); }

  .field select option { background: #1a1814; color: var(--text-primary); }

  .btn-submit {
    width: 100%;
    padding: 11px;
    margin-top: 0.5rem;
    background: var(--gold);
    border: none;
    border-radius: 10px;
    font-family: 'DM Sans', sans-serif;
    font-size: 13px;
    font-weight: 500;
    color: #0d0c0b;
    letter-spacing: 0.08em;
    cursor: pointer;
    transition: opacity 0.2s, transform 0.12s;
  }
  .btn-submit:hover { opacity: 0.86; }
  .btn-submit:active { transform: scale(0.98); }

  .form-footer {
    text-align: center;
    margin-top: 1.2rem;
    font-size: 11px;
    font-weight: 300;
    color: #3d3830;
  }
</style>
</head>
<body>

<div class="card">

  <!-- LEFT PANEL -->
  <div class="panel-left">
    <!-- dots deco -->
    <div class="dots">
      <span></span><span></span><span></span><span></span>
      <span></span><span></span><span></span><span></span>
      <span></span><span></span><span></span><span></span>
      <span></span><span></span><span></span><span></span>
    </div>

    <!-- geo deco -->
    <svg class="geo" width="180" height="180" viewBox="0 0 180 180" fill="none">
      <circle cx="90" cy="90" r="89" stroke="#c8a97e" stroke-width="0.5"/>
      <circle cx="90" cy="90" r="60" stroke="#c8a97e" stroke-width="0.5"/>
      <circle cx="90" cy="90" r="30" stroke="#c8a97e" stroke-width="0.5"/>
      <line x1="0" y1="90" x2="180" y2="90" stroke="#c8a97e" stroke-width="0.5"/>
      <line x1="90" y1="0" x2="90" y2="180" stroke="#c8a97e" stroke-width="0.5"/>
    </svg>

    <!-- brand -->
    <div class="brand">
      <div class="brand-mark">
        <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
          <path d="M8 1L15 8L8 15L1 8Z" stroke="#c8a97e" stroke-width="0.8"/>
          <circle cx="8" cy="8" r="2.5" stroke="#c8a97e" stroke-width="0.8"/>
        </svg>
      </div>
      <span class="brand-name">Attend</span>
    </div>

    <!-- welcome text -->
    <div class="welcome-block">
      <p class="welcome-label">Smart Attendance System</p>
      <h1 class="welcome-heading">Track.<br><em>Manage.</em><br>Succeed.</h1>
      <p class="welcome-desc">A unified platform for admins and teachers to manage attendance with precision.</p>
    </div>

    <p class="left-footer">Smart Attendance System © 2026</p>
  </div>

  <!-- RIGHT PANEL -->
  <div class="panel-right">
    <h2 class="form-title">Sign in</h2>
    <p class="form-sub">Access your dashboard</p>
    <div class="divider"></div>

    <form action="login" method="post">

      <div class="field">
        <label>Role</label>
        <select name="role">
          <option value="admin">Admin</option>
          <option value="teacher">Teacher</option>
        </select>
      </div>

      <div class="field">
        <label>Username</label>
        <input type="text" name="username" placeholder="Enter your username" required>
      </div>

      <div class="field">
        <label>Password</label>
        <input type="password" name="password" placeholder="••••••••" required>
      </div>

      <button type="submit" class="btn-submit">Sign in -></button>

    </form>

    <p class="form-footer">Secure access · Powered by Attend</p>
  </div>

</div>

</body>
</html>