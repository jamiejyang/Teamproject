package controller;

import controller.action.Action;
import controller.action.BookListAction;

public class ActionFactory {
	private static ActionFactory instance = new ActionFactory();

	private ActionFactory() {
		super();
	}

	public static ActionFactory getInstance() {
		return instance;
	}

	public Action getAction(String command) {
		Action action = null;
		System.out.println("ActionFactory : " + command);

		if (command.equals("book_list")) {
			action = new BookListAction();
			System.out.println("액션 구현 성공 ");
		}
		return action;
	}
}