#include <iostream>
#include <otawa/otawa.h>
#include <otawa/ipet.h>

using namespace elm;
using namespace otawa;

class TimeBuilder: public BBProcessor {
public:
	static p::declare reg;
	TimeBuilder(): BBProcessor(reg) { }

protected:

	void processBB(WorkSpace *ws, CFG *cfg, Block *b) override {
		if(!b->isBasic())
			return;
		BasicBlock *bb = b->toBasic();
		int cost = 0;
		
		for(auto i : *bb){

			if(i->isStore() or i->isControl() and i-> isConditional()) cost += 2;
			else if (i->isLoad()) cost += 5;
			else if (i->isMul()) cost += 4;
			else cost += 1;

		}

		ipet::TIME(bb) = cost;
		cout << "\tBB time is : " << *ipet::TIME(bb) << io::endl;

		
	}

};

p::declare TimeBuilder::reg = p::init("TimeBuilder", Version(1, 0, 0))
	.require(COLLECTED_CFG_FEATURE)
	.provide(ipet::BB_TIME_FEATURE);


class FlashAnalysis: public CFGProcessor {
public:
	static p::declare reg;
	FlashAnalysis(): CFGProcessor(reg) { }

protected:

	void processAll(WorkSpace *ws) override {
        CFG *cfg = ws->getStartCFG();
        int total_accesses = 0;
        int hits = 0;
        
		for (auto b : *cfg) {
            OUT(b) = BOT;
        }

        Vector<Block *> todo;
        todo.push(cfg->entry());

        while (!todo.isEmpty()) {
            Block *bb = todo.pop();
            Address current = input(bb); 
            
            if (bb->isBasic()) {
                BasicBlock *bbb = bb->toBasic();
                for (auto i : *bbb)
					current = update(current, i);
            }

            if (current != OUT(bb)) {
                OUT(bb) = current;
                for (auto e : bb->outEdges())
					todo.push(e->sink());
            }
        }


        for (auto b : *cfg) { 
            if (!b->isBasic()) continue;
            BasicBlock *bb = b->toBasic();
            
            Address state = input(bb);
            int penalty = 0;

            for (auto inst : *bb) {
                total_accesses++;

                if (state == inst->address().page())
					hits++;
            	else 
					penalty += 20;

                state = update(state, inst);
            }
            ipet::TIME(bb) += penalty;
        }

	}

	void processCFG(WorkSpace *ws, CFG *g) override {}

private:

	Address join(Address a1, Address a2) {
		if (a1 == a2) return a1;
		else if (a1 == BOT) return a2;
		else if (a2 == BOT) return a1;
		else return TOP;
	}

	Address update(Address s, Inst *i) {
		auto curr = i->address();

		return curr.page();
	}

	Address input(Block *v) {
		Address res = BOT;
		for (auto e : v->inEdges())
			res = join(res, OUT(e->source()));
		
		return res;	}

	Address flashBlock(Inst *i) {
		auto curr = i->address();
		return curr.mask(mask);
	}

	bool processBasicBlock(Block *BB) {
		Address in = input(BB);
		Address out = in;

		if(BB->isBasic()) {
			BasicBlock *bb = BB->toBasic();
			for(auto inst: *bb)
				out = update(out, inst);
		}

		Address old = OUT(BB);
		if(out != old) {
			OUT(BB) = out;
			return true;
		}

		return false;
	}


	static p::id<Address> OUT;
	static const Address TOP, BOT;
	static const t::uint32 mask = 32 - 1;
	static const ot::time cost = 10;
};

p::declare FlashAnalysis::reg = p::init("FlashAnalysis", Version(1, 0, 0))
	.require(COLLECTED_CFG_FEATURE)
	.require(ipet::BB_TIME_FEATURE);

p::id<Address> FlashAnalysis::OUT("", BOT);
const Address FlashAnalysis::TOP(-1, -2);
const Address FlashAnalysis::BOT;


int main(int argc, char **argv) {

	// check if we have exactly one parameter!
	if(argc != 2) {
		cerr << "SYNTAX: " << argv[0] << " ELF_FILE\n";
		return 1;
	}

	try {

		// this proplist is used to pass option for ELF file opening
		PropList props;

		// comment this to avoid verbose display of OTAWA
		VERBOSE(props) = true;

		// open the binary file and store it in a workspace
		WorkSpace *ws = MANAGER.load(argv[1], props);

		// compute the time of blocks and store it using ipet::TIME property
		ws->run<TimeBuilder>(props);

		// flash analysis
		ws->run<FlashAnalysis>(props);

		// compute WCET
		ws->require(ipet::WCET_FEATURE, props);

		// display the WCET that has been stored on the workspace using ipet::WCET property
		cout << "WCET = " << *ipet::WCET(ws) << io::endl;

	}
	catch(elm::Exception& e) {
		cerr << "ERROR: " << e.message() << io::endl;
		return 2;
	}

 

	return 0;
}
