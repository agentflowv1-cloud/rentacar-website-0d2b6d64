import React from 'react';

function Footer() {
  return (
    <footer className="bg-gray-200 py-12">
      <div className="container mx-auto px-4">
        <div className="flex flex-wrap justify-center mb-12">
          <div className="w-full lg:w-1/3 xl:w-1/3 p-6">
            <h5 className="text-xl mb-2 font-bold">About Us</h5>
            <p className="text-gray-600">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sit amet nulla auctor, vestibulum magna sed, convallis ex.</p>
          </div>
          <div className="w-full lg:w-1/3 xl:w-1/3 p-6">
            <h5 className="text-xl mb-2 font-bold">Contact Us</h5>
            <ul>
              <li className="mb-2">
                <a href="mailto:info@example.com" className="text-gray-600 hover:text-gray-900">info@example.com</a>
              </li>
              <li className="mb-2">
                <a href="tel:1234567890" className="text-gray-600 hover:text-gray-900">123-456-7890</a>
              </li>
              <li className="mb-2">
                <a href="https://example.com" className="text-gray-600 hover:text-gray-900">example.com</a>
              </li>
            </ul>
          </div>
          <div className="w-full lg:w-1/3 xl:w-1/3 p-6">
            <h5 className="text-xl mb-2 font-bold">Follow Us</h5>
            <ul>
              <li className="mb-2">
                <a href="https://facebook.com" className="text-gray-600 hover:text-gray-900">Facebook</a>
              </li>
              <li className="mb-2">
                <a href="https://twitter.com" className="text-gray-600 hover:text-gray-900">Twitter</a>
              </li>
              <li className="mb-2">
                <a href="https://instagram.com" className="text-gray-600 hover:text-gray-900">Instagram</a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </footer>
  );
}
export default Footer;