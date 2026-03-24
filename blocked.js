document.addEventListener("DOMContentLoaded", () => {
    const params = new URLSearchParams(location.search);
    const url      = decodeURIComponent(params.get("url") || "");
    const score    = parseInt(params.get("score") || "70");
    const category = params.get("category") || "scam";
    const reason   = decodeURIComponent(params.get("reason") || "Terdeteksi sebagai ancaman");

    document.getElementById("infoUrl").textContent   = url.length > 55 ? url.slice(0, 55) + "..." : url || "-";
    document.getElementById("infoReason").textContent = reason;
    document.getElementById("scoreVal").innerHTML     = `${score}<span style="font-size:13px;font-weight:500;color:var(--sub)">/100</span>`;

    setTimeout(() => {
      document.getElementById("trackFill").style.width = score + "%";
    }, 200);

    if (category === "judol") {
      document.getElementById("topStripe").classList.add("judol");
      document.getElementById("iconWrap").classList.add("judol");
      document.getElementById("categoryTag").classList.add("judol");
      document.getElementById("trackFill").classList.add("judol");
      document.getElementById("scoreVal").classList.add("judol");
      document.getElementById("categoryLabel").textContent = "Judi Online";
      document.getElementById("cardTitle").textContent     = "Situs Judol Diblokir";
      document.getElementById("cardDesc").textContent      = "Situs ini terindikasi sebagai platform judi online ilegal. PagarNet memblokir aksesnya untuk melindungi kamu.";
      document.getElementById("mainIcon").setAttribute("stroke", "#8b5cf6");
    } else {
      document.getElementById("categoryLabel").textContent = "Scam / Penipuan";
      document.getElementById("cardTitle").textContent     = "Situs Scam Diblokir";
      document.getElementById("cardDesc").textContent      = "Situs ini terindikasi sebagai penipuan atau phishing. Data pribadi dan uangmu bisa dicuri jika melanjutkan.";
    }

    document.getElementById("reportBtn").addEventListener("click", () => {
      chrome.runtime.sendMessage({ type: "REPORT_SITE", url, reason: category }, () => {
        const btn = document.getElementById("reportBtn");
        btn.innerHTML = `<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg> Laporan Terkirim`;
        btn.disabled = true;
        btn.style.opacity = "0.5";
      });
    });

    document.getElementById("trustBtn").addEventListener("click", () => {
      if (!url) return;
      if (!confirm("Whitelist domain ini? Gunakan hanya jika kamu yakin situs ini aman.")) return;

      chrome.runtime.sendMessage({ type: "TRUST_DOMAIN", url }, (res) => {
        if (!res?.success) return;
        const btn = document.getElementById("trustBtn");
        btn.innerHTML = `<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg> Domain Dipercaya`;
        btn.disabled = true;
        btn.style.opacity = "0.65";
        setTimeout(() => {
          location.href = url;
        }, 400);
      });
    });

    document.getElementById("proceedBtn").addEventListener("click", () => {
      if (confirm("Kamu yakin ingin melanjutkan? Situs ini mungkin berbahaya.")) {
        location.href = url;
      }
    });
});
