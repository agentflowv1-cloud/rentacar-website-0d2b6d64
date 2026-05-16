import React from 'react';
import './CardComponent.css';

interface Service {
  id: number;
  name: string;
  description: string;
  image: string;
}

function CardComponent({ service }: { service: Service }) {
  return (
    <div className="card">
      <img src={service.image} alt={service.name} />
      <h2>{service.name}</h2>
      <p>{service.description}</p>
    </div>
  );
}

export default CardComponent;