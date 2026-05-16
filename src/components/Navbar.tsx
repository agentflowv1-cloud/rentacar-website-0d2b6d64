import React from 'react';
import { Link } from 'react-router-dom';

function Navbar() {
  return (
    <nav className="bg-gray-800 text-white p-4 flex justify-between">
      <h1 className="text-2xl font-bold">Logo</h1>
      <ul className="flex items-center space-x-4">
        <li>
          <Link to="/" className="hover:text-gray-300">Home</Link>
        </li>
        <li>
          <Link to="/services" className="hover:text-gray-300">Services</Link>
        </li>
      </ul>
    </nav>
  );
}

export default Navbar;