#include "Fragment.h"
#include "Selector.h"
#include "Descriptor.h"
#include "Specifier.h"
#include "DisplayNode.h"

namespace Dezel {
namespace Style {

using Dezel::DisplayNode;

using std::distance;

//------------------------------------------------------------------------------
// MARK: Private API
//------------------------------------------------------------------------------

bool
Fragment::matchName(DisplayNode* node, Specifier& weight)
{
	if (this->name == "") {

		/*
		 * This fragment des not specify a name. Consider it a match
		 * since this is technically positive, but do not increase
		 * the weight.
		 */

		return true;
	}

	auto matched = node->getName() == this->name;

	if (matched) {
		weight.name += 1;
	}

	return matched;
}

bool
Fragment::matchType(DisplayNode* node, Specifier& weight)
{
	if (this->type == "") {

		/*
		 * This fragment des not specify a type which in this case defaults
		 * to the view type. This will match automatically since all nodes
		 * will automatically be views.
		 */

		weight.type += 1;

		return true;
	}

	/*
	 * Try to find the fragment type within the node's type vector.
	 */

	auto types = node->getTypes();

	auto beg = types.begin();
	auto end = types.end();

	auto it = find(
		beg,
		end,
		this->type
	);

	auto matched = it != end;

	if (matched) {

		/*
		 * Since types supports inheritance, we want to make sure that a base
		 * types such as View does not override an extended type such as
		 * Button. To do this, we increase the weight by the matched type
		 * to the first items in the node's type vector.
		 */

		weight.type += static_cast<int>(types.size() - distance(beg, it));
	}

	return matched;
}

bool
Fragment::matchStyle(DisplayNode* node, Specifier& weight)
{
	if (this->style == "") {

		/*
		 * This fragment des not specify a style. Consider it a match
		 * since this is technically positive, but do not increase
		 * the weight.
		 */

		return true;
	}

	auto styles = node->getStyles();

	if (styles.size() == 0) {
		return false;
	}

	/*
	 * Try to find the fragment style within the node style list. If found,
	 * increase the style weight.
	 */

	auto beg = styles.begin();
	auto end = styles.end();

	auto it = find(
		beg,
		end,
		this->style
	);

	auto matched = it != end;

	if (matched) {
		weight.style += 1;
	}

	return matched;
}

bool
Fragment::matchState(DisplayNode* node, Specifier& weight)
{
	if (this->state == "") {

		/*
		 * This fragment des not specify a style. Consider it a match
		 * since this is technically positive, but do not increase
		 * the weight.
		 */

		return true;
	}

	auto states = node->getStates();

	if (states.size() == 0) {
		return false;
	}

	/*
	 * Try to find the fragment state within the node state list. If found,
	 * increase the state weight.
	 */

	auto beg = states.begin();
	auto end = states.end();

	auto it = find(
		beg,
		end,
		this->state
	);

	auto matched = it != end;

	if (matched) {
		weight.state += 1;
	}

	return matched;
}

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

bool
Fragment::match(DisplayNode* node, Specifier& weight)
{
	Specifier w;

	auto matchedName = this->matchName(node, w);
	auto matchedType = this->matchType(node, w);
	auto matchedStyle = this->matchStyle(node, w);
	auto matchedState = this->matchState(node, w);

	if (matchedName &&
		matchedType &&
		matchedStyle &&
		matchedState) {

		weight.name += w.name;
		weight.type += w.type;
		weight.style += w.style;
		weight.state += w.state;

		return true;
	}

	return false;
}

string
Fragment::toString(int depth)
{
	string output;

	output.append(this->type);

	if (this->name.size()) {
		output.append("#");
		output.append(this->name);
	}

	if (this->style.size()) {
		output.append("@style ");
		output.append(this->style);
	}

	if (this->state.size()) {
		output.append("@state ");
		output.append(this->state);
	}

	return output;
}

}
}
