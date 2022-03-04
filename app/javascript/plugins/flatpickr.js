import flatpickr from "flatpickr";
import rangePlugin from
"flatpickr/dist/plugins/rangePlugin";

const initFlatpickr = () => {
  flatpickr(".datepicker", {
    altInput: true,
    allowInput: true,
    enableTime: true,
    plugins: [new rangePlugin({ input: "#range_end"})]
  });
}

export { initFlatpickr };
