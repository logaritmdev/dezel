#ifndef Filter_h
#define Filter_h

namespace Dezel {
namespace Style {

typedef enum {
	kTraitAll  = 0,
	kTraitName  = 1 << 0,
	kTraitType  = 1 << 1,
	kTraitStyle = 1 << 2,
	kTraitState = 1 << 3
} Trait;

inline Trait operator|(Trait a, Trait b)
{
	return static_cast<Trait>(static_cast<int>(a) | static_cast<int>(b));
}

inline Trait operator&(Trait a, Trait b)
{
	return static_cast<Trait>(static_cast<int>(a) & static_cast<int>(b));
}

}
}

#endif
