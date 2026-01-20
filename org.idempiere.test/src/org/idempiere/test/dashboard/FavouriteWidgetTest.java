package org.idempiere.test.dashboard;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Enumeration;

import org.compiere.model.MMenu;
import org.compiere.model.MTreeFavorite;
import org.compiere.model.MTreeFavoriteNode;
import org.compiere.model.MTreeNode;
import org.compiere.model.SystemIDs;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;


public class FavouriteWidgetTest extends AbstractTestCase{

    @Test
    public void testNotActiveMenu() {
    	MMenu menu = new MMenu(Env.getCtx(), SystemIDs.MENU_TEST, getTrxName());
    	assertTrue(menu.isActive());
    	
    	// add Test to favorite
    	int AD_Favorite_Tree_ID = MTreeFavorite.getFavoriteTreeID(getAD_User_ID());
    	MTreeFavoriteNode favoriteNode = new MTreeFavoriteNode(Env.getCtx(), 0, getTrxName());
    	favoriteNode.setAD_Org_ID(GARDEN_WORLD_HQ_ORG);
    	favoriteNode.setAD_Menu_ID(menu.getAD_Menu_ID());
    	favoriteNode.setAD_Tree_Favorite_ID(AD_Favorite_Tree_ID);
    	favoriteNode.setName(menu.getName());
    	favoriteNode.setIsFavourite(true);
    	favoriteNode.setIsSummary(false);
    	favoriteNode.setSeqNo(0);
    	favoriteNode.setParent_ID(0);
    	favoriteNode.saveEx();
    	
    	boolean TestFavoriteExist = checkFavouriteNode(AD_Favorite_Tree_ID, menu.getAD_Menu_ID());
		assertTrue(TestFavoriteExist);
		
		// deactivate Test menu
    	DB.executeUpdate("UPDATE AD_Menu set isactive='N' where ad_menu_id="+SystemIDs.MENU_TEST, getTrxName());
    	
    	menu = new MMenu(Env.getCtx(), SystemIDs.MENU_TEST, getTrxName());
    	assertFalse(menu.isActive());
    	
    	TestFavoriteExist = checkFavouriteNode(AD_Favorite_Tree_ID, menu.getAD_Menu_ID());
		assertFalse(TestFavoriteExist);
    }
    
    private boolean checkFavouriteNode(int AD_Favorite_Tree_ID, int Menu_ID) {
    	boolean isExist = false;
    	MTreeFavorite treeFavorite = new MTreeFavorite(Env.getCtx(), AD_Favorite_Tree_ID, getTrxName());
    	MTreeNode root = treeFavorite.getRoot();
    	Enumeration<?> enTop = root.children();
		while (enTop.hasMoreElements())
		{
			MTreeNode nd = (MTreeNode) enTop.nextElement();
			if (nd.isOnBar() && nd.getMenu_ID() > 0)
			{
				if(nd.getMenu_ID() == Menu_ID) {
					isExist = true;
					break;
				}
			}
		}
		return isExist;
	}
}



