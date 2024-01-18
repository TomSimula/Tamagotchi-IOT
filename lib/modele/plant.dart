class Plant{
  double life;
  double water;
  double temperature;
  double light;

  Plant(this.life, this.water, this.temperature, this.light);

  updatePlant(Map plantInfo){
    temperature = (plantInfo['temperature'] as int).toDouble();
    light = (plantInfo['lumiere'] as int).toDouble();
    water = (plantInfo['eau'] as int).toDouble();
    life = (plantInfo['pv'] as int).toDouble();
  }
}