/* REFYNITY — shared interactions
   Progressive enhancement: everything degrades gracefully without JS. */
(function () {
  "use strict";

  /* ---- Sticky header shadow ---- */
  var header = document.querySelector(".site-header");
  if (header) {
    var onScroll = function () {
      header.classList.toggle("is-scrolled", window.scrollY > 8);
    };
    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });
  }

  /* ---- Mobile nav ---- */
  var nav = document.querySelector(".nav");
  var toggle = document.querySelector(".nav__toggle");
  if (nav && toggle) {
    var setNav = function (open) {
      nav.classList.toggle("is-open", open);
      document.body.classList.toggle("nav-open", open);
      toggle.setAttribute("aria-expanded", String(open));
    };
    toggle.addEventListener("click", function () {
      setNav(!nav.classList.contains("is-open"));
    });
    nav.querySelectorAll(".nav__link, .nav__cta a").forEach(function (a) {
      a.addEventListener("click", function () { setNav(false); });
    });
    var backdrop = nav.querySelector(".nav__backdrop");
    if (backdrop) backdrop.addEventListener("click", function () { setNav(false); });
    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape") setNav(false);
    });
  }

  /* ---- Reveal on scroll ---- */
  var reveals = document.querySelectorAll(".reveal");
  if ("IntersectionObserver" in window && reveals.length) {
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add("is-visible");
          io.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12, rootMargin: "0px 0px -8% 0px" });
    reveals.forEach(function (el) { io.observe(el); });
  } else {
    reveals.forEach(function (el) { el.classList.add("is-visible"); });
  }

  /* ---- Member sign-in modal (stub) ---- */
  var modal = document.querySelector("[data-modal='member']");
  if (modal) {
    var openers = document.querySelectorAll("[data-open='member']");
    var lastFocus = null;
    var openModal = function (e) {
      if (e) e.preventDefault();
      lastFocus = document.activeElement;
      modal.classList.add("is-open");
      modal.setAttribute("aria-hidden", "false");
      var close = modal.querySelector(".modal__close");
      if (close) close.focus();
    };
    var closeModal = function () {
      modal.classList.remove("is-open");
      modal.setAttribute("aria-hidden", "true");
      if (lastFocus) lastFocus.focus();
    };
    openers.forEach(function (o) { o.addEventListener("click", openModal); });
    modal.querySelectorAll("[data-close]").forEach(function (c) {
      c.addEventListener("click", closeModal);
    });
    document.addEventListener("keydown", function (e) {
      if (e.key === "Escape" && modal.classList.contains("is-open")) closeModal();
    });
  }

  /* ---- Contact form → FormSubmit (delivers to shauna@refynity.co) ---- */
  var form = document.querySelector("[data-contact-form]");
  if (form) {
    var ENDPOINT = "https://formsubmit.co/ajax/shauna@refynity.co";
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      var status = form.querySelector(".form__status");
      if (!form.checkValidity()) {
        form.reportValidity();
        return;
      }
      var btn = form.querySelector("button[type='submit']");
      var btnHTML = btn ? btn.innerHTML : "";
      var firstName = (((form.querySelector("[name='name']") || {}).value) || "").trim().split(" ")[0];
      if (status) { status.className = "form__status"; status.textContent = ""; }
      if (btn) { btn.disabled = true; btn.textContent = "Sending…"; }

      fetch(ENDPOINT, {
        method: "POST",
        headers: { Accept: "application/json" },
        body: new FormData(form)
      })
        .then(function (r) { if (!r.ok) throw new Error("Request failed"); return r.json(); })
        .then(function () {
          if (status) {
            status.textContent =
              (firstName ? "Thanks, " + firstName + " — " : "Thanks — ") +
              "your message is on its way to Refynity. We'll be in touch within 1–2 business days.";
            status.classList.add("is-success");
          }
          form.reset();
        })
        .catch(function () {
          if (status) {
            status.textContent =
              "Something went wrong sending your message. Please email shauna@refynity.co directly and we'll get right back to you.";
            status.classList.add("is-error");
          }
        })
        .finally(function () {
          if (btn) { btn.disabled = false; btn.innerHTML = btnHTML; }
        });
    });
  }

  /* ---- Footer year ---- */
  var yearEl = document.querySelector("[data-year]");
  if (yearEl) yearEl.textContent = new Date().getFullYear();
})();
