class ParticleSystem {
  ArrayList<Particle> particles; //arraylist of all the particles within a single particle system

  ParticleSystem() {
    particles = new ArrayList<Particle>();
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  void addParticle() {
    for (int i =0; i<30; i++) {
      particles.add(new Particle(1000, 0.001, random(0, PI*2)));
    }
  }
}