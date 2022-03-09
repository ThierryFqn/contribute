import flatpickr from "flatpickr";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";
import { French } from "flatpickr/dist/l10n/fr.js"

const initFlatpickr = () => {
  flatpickr(".datepicker", {
    altInput: true,
    allowInput: true,
    enableTime: true,
    locale: French,
    minDate: "today",
    defaultHour: 10,
    time_24hr: true,
    mode: "range",
    // plugins: [new rangePlugin({ input: "#search_range_end"})],
    altFormat: "d F, H:i",
  });
}

export { initFlatpickr };
