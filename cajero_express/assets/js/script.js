function formatCardNumber(input) {
    input.value = input.value.replace(/\D/g, '').replace(/(\d{4})(?=\d)/g, '$1 ');
    if (input.value.length > 19) {
        input.value = input.value.slice(0, 19);
    }
}

function formatNip(input) {
    input.value = input.value.replace(/\D/g, '');
    if (input.value.length > 4) {
        input.value = input.value.slice(0, 4);
    }
}