namespace xppc{
  extern int xr;

  float xrnd();
  float grnd();

  void start();
  void stop();
  void choose(int);
  void ini(int);
  void fin();
  void eout();

  void flini(int, int);
  void flone(unsigned long long);

  struct mcid:std::pair<int,unsigned long long>{
    int frame;
  };

  struct DOM{
    float r[3];
  };

  struct ikey{
    int str, dom;

    bool isinice() const{
      return str>0 && dom>=1 && dom<=60;
    }

    bool operator< (const ikey & rhs) const {
      return str == rhs.str ? dom < rhs.dom : str < rhs.str;
    }

    bool operator!= (const ikey & rhs) const {
      return str != rhs.str || dom != rhs.dom;
    }
  };

  struct OM:DOM,ikey{};
  extern std::vector<OM> i3oms;
  extern std::map<ikey, float> rdes, hvs;
  void initialize(float);
  const DOM& flget(int str, int dom);
  void flshift(float [], float [], float * = NULL);

  struct ihit{
    ikey omkey;
    mcid track;
    float time;
#ifdef PDIR
    float dir;
#endif

    bool operator< (const ihit & rhs) const {
      return
	track!=rhs.track ? track<rhs.track :
	omkey!=rhs.omkey ? omkey<rhs.omkey :
#ifdef PDIR
	dir!=rhs.dir ? dir<rhs.dir :
#endif
	time<rhs.time;
    }
  };

  void set_res(float);
#ifdef PDIR
  void set_res(float, float);
#endif

#ifdef POUT
  struct pout{
    float r[4], n[4];
  };

  typedef std::map<ihit, std::vector<pout> > outz;
#else
  typedef std::map<ihit, unsigned int> outz;
#endif
  extern outz hitz;

  void eini();
  void efin();

  void sett(float, float, float, std::pair<int,unsigned long long>, int);
  template <class T> void addp(float, float, float, float, float, T);
#ifdef CLST
  void addp(float, float, float, float, unsigned long long, float, float);
#endif
}
