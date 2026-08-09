// FashionStore Client Interactivity Script (Vanilla HTML, CSS, JavaScript)

document.addEventListener('DOMContentLoaded', function() {
    console.log("FashionStore JavaScript initialized.");

    // Payment Option Selection Styling
    const paymentCards = document.querySelectorAll('.payment-card');
    paymentCards.forEach(function(card) {
        card.addEventListener('click', function() {
            paymentCards.forEach(c => c.classList.remove('selected'));
            this.classList.add('selected');
            const radio = this.querySelector('input[type="radio"]');
            if (radio) radio.checked = true;
        });
    });

    // Add To Cart Toast Feedback
    const cartForms = document.querySelectorAll('.add-to-cart-form');
    cartForms.forEach(function(form) {
        form.addEventListener('submit', function() {
            showToast("Item added to cart! 🛒");
        });
    });
});

function showToast(message) {
    let toast = document.createElement('div');
    toast.className = 'toast-notification';
    toast.innerText = message;
    document.body.appendChild(toast);

    setTimeout(() => {
        toast.classList.add('show');
    }, 50);

    setTimeout(() => {
        toast.classList.remove('show');
        setTimeout(() => toast.remove(), 300);
    }, 2500);
}

// Toast CSS injection
const style = document.createElement('style');
style.innerHTML = `
.toast-notification {
    position: fixed;
    bottom: 24px;
    right: 24px;
    background: #17181c;
    color: #ffffff;
    padding: 12px 24px;
    border-radius: 8px;
    font-weight: 600;
    font-size: 14px;
    box-shadow: 0 6px 20px rgba(0,0,0,0.2);
    z-index: 9999;
    opacity: 0;
    transform: translateY(20px);
    transition: all 0.3s ease;
    border-left: 4px solid #ff3e6c;
}
.toast-notification.show {
    opacity: 1;
    transform: translateY(0);
}
`;
document.head.appendChild(style);
