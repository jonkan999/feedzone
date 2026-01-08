// Shared product card rendering and cart functionality

export function renderProductCard(product) {
  // Check if product is already in cart
  const cart = JSON.parse(localStorage.getItem('feedzone-cart') || '[]');
  const cartItem = cart.find((item) => item.product_id === product.id);
  const initialQuantity = cartItem ? cartItem.quantity : 0;
  const isInCart = initialQuantity > 0;
  
  return `
    <div class="product-card bg-white hover:bg-gray-100 border border-gray-200 hover:border-gray-300 rounded-lg overflow-hidden transition-all duration-300 cursor-pointer" data-product-id="${product.id}" data-product-link>
      <img src="${product.image_url || '/images/placeholder.jpg'}" alt="${product.name}" class="w-full h-48 object-cover">
      <div class="p-8">
        <h3 class="font-bold text-sm mb-1 text-gray-900 line-clamp-2">${product.name}</h3>
        <p class="text-xs text-gray-600 mb-3 line-clamp-2">${product.description || ''}</p>
        <div class="flex items-center justify-between">
          <span class="text-lg font-bold text-gray-900">${product.price.toFixed(2)} SEK</span>
          <div class="quantity-controls" data-product-id="${product.id}" data-product-name="${product.name}" data-product-price="${product.price}">
            ${isInCart ? `
              <div class="flex items-center gap-1 quantity-buttons">
                <button class="quantity-btn minus bg-gray-200 hover:bg-gray-300 text-gray-700 w-8 h-8 rounded flex items-center justify-center font-semibold transition-colors" data-action="decrease">−</button>
                <input type="number" class="quantity-input w-12 h-8 text-center border border-gray-300 rounded font-semibold text-sm" value="${initialQuantity}" min="1" data-product-id="${product.id}">
                <button class="quantity-btn plus bg-gray-200 hover:bg-gray-300 text-gray-700 w-8 h-8 rounded flex items-center justify-center font-semibold transition-colors" data-action="increase">+</button>
              </div>
            ` : `
              <button class="kop-btn bg-primary text-white px-6 py-2 rounded font-semibold hover:bg-opacity-90 transition-all uppercase cursor-pointer">KÖP</button>
            `}
          </div>
        </div>
      </div>
    </div>
  `;
}

export function updateCartQuantity(productId, quantity) {
  const cart = JSON.parse(localStorage.getItem('feedzone-cart') || '[]');
  const itemIndex = cart.findIndex((item) => item.product_id === productId);
  
  if (itemIndex >= 0) {
    if (quantity <= 0) {
      cart.splice(itemIndex, 1);
      // Transform back to KÖP button
      const productCard = document.querySelector(`[data-product-id="${productId}"]`);
      if (productCard) {
        const controlsDiv = productCard.querySelector('.quantity-controls');
        if (controlsDiv) {
          const quantityButtons = controlsDiv.querySelector('.quantity-buttons');
          if (quantityButtons) {
            quantityButtons.style.opacity = '0';
            quantityButtons.style.transform = 'scale(0.8)';
            
            setTimeout(() => {
              controlsDiv.innerHTML = `<button class="kop-btn bg-primary text-white px-6 py-2 rounded font-semibold hover:bg-opacity-90 transition-all uppercase cursor-pointer">KÖP</button>`;
              
              const newKopBtn = controlsDiv.querySelector('.kop-btn');
              if (newKopBtn) {
                newKopBtn.style.opacity = '0';
                newKopBtn.style.transform = 'scale(0.8)';
                setTimeout(() => {
                  newKopBtn.style.transition = 'all 0.3s ease';
                  newKopBtn.style.opacity = '1';
                  newKopBtn.style.transform = 'scale(1)';
                }, 10);
              }
            }, 150);
          }
        }
      }
    } else {
      cart[itemIndex].quantity = quantity;
    }
    localStorage.setItem('feedzone-cart', JSON.stringify(cart));
    window.dispatchEvent(new Event('cart-updated'));
  }
}

export function setupProductCardListeners(container) {
  // Handle KÖP button clicks
  container.addEventListener('click', (e) => {
    const target = e.target;
    const kopBtn = target.closest('.kop-btn');
    
    if (kopBtn) {
      e.preventDefault();
      e.stopPropagation();
      const controlsDiv = kopBtn.closest('.quantity-controls');
      const productId = controlsDiv.getAttribute('data-product-id');
      const productName = controlsDiv.getAttribute('data-product-name');
      const productPrice = parseFloat(controlsDiv.getAttribute('data-product-price') || '0');
      
      // Add to cart
      const cart = JSON.parse(localStorage.getItem('feedzone-cart') || '[]');
      cart.push({
        product_id: productId,
        product_name: productName,
        price: productPrice,
        quantity: 1,
      });
      localStorage.setItem('feedzone-cart', JSON.stringify(cart));
      window.dispatchEvent(new Event('cart-updated'));
      
      // Animate button transformation
      kopBtn.style.opacity = '0';
      kopBtn.style.transform = 'scale(0.8)';
      
      setTimeout(() => {
        controlsDiv.innerHTML = `
          <div class="flex items-center gap-1 quantity-buttons">
            <button class="quantity-btn minus bg-gray-200 hover:bg-gray-300 text-gray-700 w-8 h-8 rounded flex items-center justify-center font-semibold transition-colors" data-action="decrease">−</button>
            <input type="number" class="quantity-input w-12 h-8 text-center border border-gray-300 rounded font-semibold text-sm" value="1" min="1" data-product-id="${productId}">
            <button class="quantity-btn plus bg-gray-200 hover:bg-gray-300 text-gray-700 w-8 h-8 rounded flex items-center justify-center font-semibold transition-colors" data-action="increase">+</button>
          </div>
        `;
        
        const quantityButtons = controlsDiv.querySelector('.quantity-buttons');
        if (quantityButtons) {
          quantityButtons.style.opacity = '0';
          quantityButtons.style.transform = 'scale(0.8)';
          
          setTimeout(() => {
            quantityButtons.style.transition = 'all 0.3s ease';
            quantityButtons.style.opacity = '1';
            quantityButtons.style.transform = 'scale(1)';
          }, 10);
        }
      }, 150);
      return;
    }
    
    const quantityBtn = target.closest('.quantity-btn');
    if (quantityBtn) {
      e.preventDefault();
      e.stopPropagation();
      const action = quantityBtn.getAttribute('data-action');
      const controlsDiv = quantityBtn.closest('.quantity-controls');
      const productId = controlsDiv.getAttribute('data-product-id');
      const input = controlsDiv.querySelector('.quantity-input');
      
      if (!input || !productId) return;
      
      let quantity = parseInt(input.value) || 1;
      
      if (action === 'increase') {
        quantity += 1;
      } else if (action === 'decrease' && quantity > 1) {
        quantity -= 1;
      }
      
      input.value = quantity.toString();
      updateCartQuantity(productId, quantity);
      return;
    }
    
    // Handle product card click for navigation
    const productCard = target.closest('[data-product-link]');
    if (productCard) {
      // Don't navigate if clicking on quantity controls or buttons
      if (target.closest('.quantity-controls') || target.closest('button') || target.closest('input')) {
        return;
      }
      const productId = productCard.getAttribute('data-product-id');
      if (productId) {
        window.location.href = `/products/${productId}`;
      }
    }
  });
  
  // Handle quantity input changes
  container.addEventListener('change', (e) => {
    const target = e.target;
    if (target.classList.contains('quantity-input')) {
      const productId = target.getAttribute('data-product-id');
      const quantity = parseInt(target.value) || 1;
      
      if (productId) {
        updateCartQuantity(productId, Math.max(1, quantity));
      }
    }
  });
}

