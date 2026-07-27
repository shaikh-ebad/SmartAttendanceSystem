<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<div class="welcome-wrapper">

    <div class="welcome-card">

        <h1>Welcome 👋</h1>

        <p class="subtitle">
            Smart Attendance System Dashboard
        </p>

        <div class="info-box">
            <p>
                Select an option from the menu to begin managing your system.
            </p>
        </div>

    </div>

</div>

<style>

/* CENTERING */
.welcome-wrapper {
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}

/* CARD */
.welcome-card {
    background: #161513;
    border-radius: 20px;
    padding: 40px;
    width: 100%;
    max-width: 500px;
    text-align: center;
    border: 1px solid rgba(255,255,255,0.08);
    box-shadow: 0 10px 30px rgba(0,0,0,0.4);
    color: #f0e8dc;
}

/* TITLE */
.welcome-card h1 {
    font-size: 32px;
    margin-bottom: 10px;
    color: #c8a97e;
}

/* SUBTITLE */
.subtitle {
    font-size: 14px;
    color: #a09080;
    margin-bottom: 25px;
}

/* INFO BOX */
.info-box {
    background: #0d0c0b;
    padding: 15px;
    border-radius: 10px;
    border: 1px solid rgba(255,255,255,0.05);
}

</style>