#ifndef StyleResolver_h
#define StyleResolver_h

namespace Dezel {
	class DisplayNode;
	class DisplayNodeFrame;
}

namespace Dezel {
namespace Style {

class StyleResolver {

private:

	DisplayNode* node;
	
public:

	StyleResolver(DisplayNode* node);

	void resolve();

};

}
}

#endif
