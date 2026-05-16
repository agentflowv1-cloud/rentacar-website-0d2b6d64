import React from 'react';

function Navbar() {
  return (
    <nav className="bg-gray-800 text-white p-4 flex justify-between">
      <h1 className="text-2xl font-bold">Logo</h1>
      <ul className="flex items-center space-x-4">
        <li>
          <a href="/" className="hover:text-gray-300">Home</a>
        </li>
        <li>
          <a href="/services" className="hover:text-gray-300">Services</a>
        </li>
      </ul>
    </nav>
  );
}
export default Navbar;
