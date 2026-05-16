import React from 'react';
import CardComponent from '../components/CardComponent';
import './Home.css';

const services = [
  { id: 1, name: 'Economy', description: 'Our economy cars are perfect for city driving.', image: 'economy.jpg' },
  { id: 2, name: 'Compact', description: 'Our compact cars are ideal for short trips.', image: 'compact.jpg' },
  { id: 3, name: 'Intermediate', description: 'Our intermediate cars are great for road trips.', image: 'intermediate.jpg' }
];

function Home() {
  return (
    <div className="home">
      <h1>Rent a Car Services</h1>
      <div className="card-container">
        {services.map((service) => (
          <CardComponent key={service.id} service={service} />
        ))}
      </div>
    </div>
  );
}
export default Home;
