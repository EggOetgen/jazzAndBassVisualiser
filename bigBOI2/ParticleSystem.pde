class ParticleSystem {
  ArrayList<Particles> particles; //arraylist of all the particles within a single particle system

  ParticleSystem() {
   particles = new ArrayList<Particles>();
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particles p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  void addParticle() {
    for (int i =0; i<30; i++) {
      particles.add(new Particles(1000, 0.001, random(0, PI*2)));
    }
  }
}