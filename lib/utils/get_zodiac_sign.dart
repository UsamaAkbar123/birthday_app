class ZodiacSign {
  String getZodiacSign(int day, int month) {
    if (month == 1) {
      if (day < 20) {
        return 'assets/images/Capricorn.png';
      } else {
        return 'assets/images/Aquarius.png';
      }
    } else if (month == 2) {
      if (day < 19) {
        return 'assets/images/Aquarius.png';
      } else {
        return 'assets/images/Pisces.png';
      }
    } else if (month == 3) {
      if (day < 21) {
        return 'assets/images/Pisces.png';
      } else {
        return 'assets/images/Aries.png';
      }
    } else if (month == 4) {
      if (day < 20) {
        return 'assets/images/Aries.png';
      } else {
        return 'assets/images/Taurus.png';
      }
    } else if (month == 5) {
      if (day < 21) {
        return 'assets/images/Taurus.png';
      } else {
        return 'assets/images/Gemini.png';
      }
    } else if (month == 6) {
      if (day < 21) {
        return 'assets/images/Gemini.png';
      } else {
        return 'assets/images/Cancer.png';
      }
    } else if (month == 7) {
      if (day < 23) {
        return 'assets/images/Cancer.png';
      } else {
        return 'assets/images/Leo.png';
      }
    } else if (month == 8) {
      if (day < 23) {
        return 'assets/images/Leo.png';
      } else {
        return 'assets/images/Virgo.png';
      }
    } else if (month == 9) {
      if (day < 23) {
        return 'assets/images/Virgo.png';
      } else {
        return 'assets/images/Libra.png';
      }
    } else if (month == 10) {
      if (day < 23) {
        return 'assets/images/Libra.png';
      } else {
        return 'assets/images/Scorpio.png';
      }
    } else if (month == 11) {
      if (day < 22) {
        return 'assets/images/Scorpio.png';
      } else {
        return 'assets/images/Sagittarius.png';
      }
    } else if (month == 12) {
      if (day < 22) {
        return 'assets/images/Sagittarius.png';
      } else {
        return 'assets/images/Capricorn.png';
      }
    }
    return 'assets/images/Aries.png';
  }


  String getZodiacName(int day, int month) {
    if (month == 1) {
      if (day < 20) {
        return 'Capricorn';
      } else {
        return 'Aquarius';
      }
    } else if (month == 2) {
      if (day < 19) {
        return 'Aquarius';
      } else {
        return 'Pisces';
      }
    } else if (month == 3) {
      if (day < 21) {
        return 'Pisces';
      } else {
        return 'Aries';
      }
    } else if (month == 4) {
      if (day < 20) {
        return 'Aries';
      } else {
        return 'Taurus';
      }
    } else if (month == 5) {
      if (day < 21) {
        return 'Taurus';
      } else {
        return 'Gemini';
      }
    } else if (month == 6) {
      if (day < 21) {
        return 'Gemini';
      } else {
        return 'Cancer';
      }
    } else if (month == 7) {
      if (day < 23) {
        return 'Cancer';
      } else {
        return 'Leo';
      }
    } else if (month == 8) {
      if (day < 23) {
        return 'Leo';
      } else {
        return 'Virgo';
      }
    } else if (month == 9) {
      if (day < 23) {
        return 'Virgo';
      } else {
        return 'Libra';
      }
    } else if (month == 10) {
      if (day < 23) {
        return 'Libra';
      } else {
        return 'Scorpio';
      }
    } else if (month == 11) {
      if (day < 22) {
        return 'Scorpio';
      } else {
        return 'Sagittarius';
      }
    } else if (month == 12) {
      if (day < 22) {
        return 'Sagittarius';
      } else {
        return 'Capricorn';
      }
    }
    return 'Aries';
  }

}