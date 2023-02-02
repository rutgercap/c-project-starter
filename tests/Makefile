# main srcs / dirs
INCL_DIR	:=	../includes
SRCS_DIR	:=	../srcs
OBJ_DIR		:=	../objs
MAIN_OBJS	:=	$(addprefix $(OBJ_DIR)/, $(SRCS:.cpp=.o))
VPATH		:=	$(subst $(space),:,$(shell find $(SRCS_DIR) -type d))

# combined srcs / objs
TEST_SRCS	:=	$(wildcard *_test.cpp)
TEST_OBJS	:=	$(addprefix $(OBJ_DIR)/, $(TEST_SRCS:.cpp=.o))
ALL_OBJS	:=	$(TEST_OBJS) $(MAIN_OBJS)

# results
RES_DIR		:=	results
RESULTS		:=	$(patsubst %.cpp,$(RES_DIR)/%.txt,$(TEST_SRCS))
BUILD_DIRS	:=	$(RES_DIR) $(OBJ_DIR)

# Config
CC			:=	c++
FLAGS		:=	-Wall -Wextra -fsanitize=address -g
EXTENSION	:=	.out

test: $(BUILD_DIRS) $(ALL_OBJS) $(RESULTS)
	@echo "success!"
	@echo results can be found in results/

$(RES_DIR)/%.txt: $(OBJ_DIR)/%$(EXTENSION)
	@$(info running $(notdir $(basename $@)))
	@-./$< > $@ 2>> $(basename $@)_errors.txt

$(OBJ_DIR)/%$(EXTENSION): $(OBJ_DIR)/%.o
	@$(CC) $(MAIN_OBJS) $< $(FLAGS) -o $@

$(OBJ_DIR)/%.o: $(notdir %.cpp)
	@mkdir -p $(OBJ_DIR)
	@echo compiling $(notdir $(basename $<))
	@$(CC) $(FLAGS) -c $< -I$(INCL_DIR) -I$(UNITY_DIR)/src $(RL_INC) -o $@

dtest: $(BUILD_DIRS) $(ALL_OBJS) $(RESULTS)
	lldb $(OBJ_DIR)/parse_tester$(EXTENSION)

$(RES_DIR):
	@mkdir -p $(RES_DIR)

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

echo:
	@echo

clean:
	@rm -rf $(OBJ_DIR)
	@rm -rf $(RES_DIR)

.PRECIOUS: $(OBJ_DIR)%$(TARGET_EXTENSION)