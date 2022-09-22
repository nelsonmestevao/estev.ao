import topbar from "../../vendor/topbar";

export function registerTopbar() {
  // Show progress bar on live navigation and form submits.
  topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });

  let topBarScheduled: number | undefined = undefined;

  // Only displays if still loading after 120 msec
  window.addEventListener("phx:page-loading-start", (_info) => {
    if (!topBarScheduled) {
      topBarScheduled = setTimeout(() => topbar.show(), 120);
    }
  });

  window.addEventListener("phx:page-loading-stop", (_info) => {
    clearTimeout(topBarScheduled);
    topBarScheduled = undefined;
    topbar.hide();
  });
}
