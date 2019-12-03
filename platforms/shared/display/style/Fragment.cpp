#include "Fragment.h"
#include "Selector.h"
#include "Descriptor.h"
#include "Importance.h"
#include "DisplayNode.h"

namespace Dezel {
namespace Style {

using Dezel::DisplayNode;

using std::distance;

//------------------------------------------------------------------------------
// MARK: Private API
//------------------------------------------------------------------------------

bool
Fragment::matchName(DisplayNode* node, Importance& importance)
{
	if (this->name == "") {

		/*
		 * This fragment des not specify a name. Consider it a match
		 * since this is technically positive, but do not increase
		 * the importance.
		 */

		return true;
	}

	auto matched = node->getName() == this->name;

	if (matched) {
		importance.name += 1;
	}

	return matched;
}

bool
Fragment::matchType(DisplayNode* node, Importance& importance)
{
	if (this->type == "") {

		/*
		 * This fragment des not specify a type which in this case defaults
		 * to the view type. This will match automatically since all nodes
		 * will automatically be views.
		 */

		importance.type += 1;

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
		 * Button. To do this, we increase the importance by the matched type
		 * to the first items in the node's type vector.
		 */

		importance.type += static_cast<int>(types.size() - distance(beg, it));
	}

	return matched;
}

bool
Fragment::matchStyle(DisplayNode* node, Importance& importance)
{
	if (this->styles.size() == 0) {

		/*
		 * This fragment des not specify a style. Consider it a match
		 * since this is technically positive, but do not increase
		 * the importance.
		 */

		return true;
	}

	auto styles = node->getStyles();

	if (styles.size() == 0) {
		return false;
	}

	/*
	 * Try to find the fragment style within the node style list. If found,
	 * increase the style importance.
	 */

	auto beg = styles.begin();
	auto end = styles.end();

	bool success = false;

	for (auto& style : this->styles) {

		auto it = find(
			beg,
			end,
			style
		);

		auto matched = it != end;

		if (matched) {
			success = true;
			importance.style += 1;
		}
	}

	return success;
}

bool
Fragment::matchState(DisplayNode* node, Importance& importance)
{
	if (this->states.size() == 0) {

		/*
		 * This fragment des not specify a style. Consider it a match
		 * since this is technically positive, but do not increase
		 * the importance.
		 */

		return true;
	}

	auto states = node->getStates();

	if (states.size() == 0) {
		return false;
	}

	/*
	 * Try to find the fragment state within the node state list. If found,
	 * increase the state importance.
	 */

	auto beg = states.begin();
	auto end = states.end();

	bool success = false;

	for (auto& state : this->states) {

		auto it = find(
			beg,
			end,
			state
		);

		auto matched = it != end;

		if (matched) {
			success = true;
			importance.state += 1;
		}
	}

	return success;
}

//------------------------------------------------------------------------------
// MARK: Public API
//------------------------------------------------------------------------------

bool
Fragment::match(DisplayNode* node, Importance& importance)
{
	Importance i;

	auto matchedName = this->matchName(node, i);
	auto matchedType = this->matchType(node, i);
	auto matchedStyle = this->matchStyle(node, i);
	auto matchedState = this->matchState(node, i);

	if (matchedName &&
		matchedType &&
		matchedStyle &&
		matchedState) {

		importance.name += i.name;
		importance.type += i.type;
		importance.style += i.style;
		importance.state += i.state;

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

	if (this->styles.size()) {
		for (auto style : this->styles) {
			output.append(".");
			output.append(style);
		}
	}

	if (this->states.size()) {
		for (auto state : this->states) {
			output.append(":");
			output.append(state);
		}
	}

	return output;
}

}
}
