import flatpickr from "flatpickr";
import rangePlugin from
"flatpickr/dist/plugins/rangePlugin";

const initFlatpickr = () => {
  flatpickr(".datepicker", {
    altInput: true,
    allowInput: true,
    enableTime: true,
    minDate: "today",
    plugins: [new rangePlugin({ input: "#search_range_end"})]
  });
}

export { initFlatpickr };
