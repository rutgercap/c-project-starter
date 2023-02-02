NAME				:=	program
CC					:=	c++
CFLAGS				:=	-Wall -Wextra -std=c++11 -pedantic
################################################################################
# EXTRA FLAGS
ifdef PROD
# Used for evals
CFLAGS				+=	-Werror
else
# Used for development
CFLAGS				+=	-g3 -fsanitize=address
endif
################################################################################
# COLORS
BOLD 				:=	\e[1m
RESET 				:=	\e[0m
LIGHT_GREEN 		:=	\e[92m
LIGHT_CYAN 			:=	\e[96m
################################################################################
# DIRECTORIES
INCL_DIR			:=	includes
SRC_DIR				:=	srcs
TEST_DIR			:=	tests
OBJ_DIR				:=	objs
VPATH 				:=	$(subst $(space),:,$(shell find $(SRC_DIR) -type d))
################################################################################
# SOURCES / OBJECTS
MAIN				:=	main.cpp
export SRCS			:=	hello_world.cpp \
						calculate.cpp

TEST_OBJS			:=	$(addprefix $(OBJ_DIR)/, $(SRCS:.cpp=.o))
MAIN				:=	main.cpp
MAIN_OBJ			:=	$(addprefix $(OBJ_DIR)/, $(MAIN:.cpp=.o))
OBJS				:=	$(TEST_OBJS) $(MAIN_OBJ)
################################################################################
# ARGS FOR DEV
ARGS				:= 

all: $(NAME)

$(NAME):	$(OBJ_DIR) $(OBJS)
	@printf "$(LIGHT_CYAN)$(BOLD)make$(RESET)   [$(LIGHT_GREEN)$(NAME)$(RESET)] : "
	$(CC) $(OBJS) $(CFLAGS) -o $(NAME)

$(OBJ_DIR)/%.o: $(notdir %.cpp)
	@$(CC) $(CFLAGS) -c $< -I$(INCL_DIR) -o $@
	@printf "$(LIGHT_CYAN)$(BOLD)make$(RESET)   [$(LIGHT_GREEN)$(NAME)$(RESET)] : "
	@printf "$(notdir $(basename $@)) created\n"

run: $(NAME)
	./$(NAME) $(ARGS)

test: $(OBJ_DIR)
	@$(MAKE) -C $(TEST_DIR) test

lldb: $(NAME)
	lldb $(NAME) -- $(ARGS)

clean:
	@rm -rf $(OBJ_DIR)

fclean:	clean
	@rm -f $(NAME)
	$(MAKE) -C $(TEST_DIR) clean

re: fclean all

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

.PHONY: all clean fclean re lldb