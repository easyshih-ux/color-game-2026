(() => {
  const STORAGE_KEY = "colorGameTimer";
  const pageName = decodeURIComponent(window.location.pathname.split("/").pop() || "index.html");
  const isOpeningPage = pageName === "index.html";
  const isFinishPage = pageName === "final-ending.html";

  function readTimer() {
    try {
      return JSON.parse(window.localStorage.getItem(STORAGE_KEY) || "null");
    } catch (error) {
      return null;
    }
  }

  function writeTimer(timer) {
    window.localStorage.setItem(STORAGE_KEY, JSON.stringify(timer));
  }

  let timer = readTimer();
  if (!timer || !Number.isFinite(timer.startedAt) || (isOpeningPage && timer.finishedAt)) {
    timer = { startedAt: Date.now(), finishedAt: null };
    writeTimer(timer);
  }

  if (isFinishPage && !timer.finishedAt) {
    timer.finishedAt = Date.now();
    writeTimer(timer);
  }

  const badge = document.createElement("div");
  badge.id = "gameTimerBadge";
  badge.setAttribute("role", "timer");
  badge.setAttribute("aria-live", "off");
  Object.assign(badge.style, {
    position: "fixed",
    left: "12px",
    bottom: "12px",
    zIndex: "10000",
    minWidth: "128px",
    padding: "9px 13px",
    border: "1px solid rgba(255,255,255,.32)",
    borderRadius: "8px",
    background: "rgba(10,18,35,.86)",
    color: "#fff",
    fontFamily: "Microsoft JhengHei, Noto Sans TC, system-ui, sans-serif",
    fontSize: "15px",
    fontWeight: "800",
    lineHeight: "1.35",
    textAlign: "center",
    boxShadow: "0 6px 18px rgba(0,0,0,.2)",
    backdropFilter: "blur(5px)"
  });
  document.body.appendChild(badge);

  function formatElapsed(milliseconds) {
    const totalSeconds = Math.max(0, Math.floor(milliseconds / 1000));
    const hours = Math.floor(totalSeconds / 3600);
    const minutes = Math.floor((totalSeconds % 3600) / 60);
    const seconds = totalSeconds % 60;
    const time = [minutes, seconds].map((value) => String(value).padStart(2, "0")).join(":");
    return hours ? `${String(hours).padStart(2, "0")}:${time}` : time;
  }

  function renderTimer() {
    const endTime = timer.finishedAt || Date.now();
    badge.textContent = `${timer.finishedAt ? "完成時間" : "遊戲時間"} ${formatElapsed(endTime - timer.startedAt)}`;
  }

  renderTimer();
  if (!timer.finishedAt) window.setInterval(renderTimer, 1000);
})();
